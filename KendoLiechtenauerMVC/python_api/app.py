# -*- coding: utf-8 -*-
"""
Python OpenCV + MediaPipe 자세 분석 서버
---------------------------------------
Java JSP/Servlet 프로젝트에서 이미지 경로를 보내면
이 서버가 이미지를 읽고 MediaPipe Pose로 관절 위치를 찾는다.

실행 방법
1. pip install flask opencv-python mediapipe
2. python app.py
3. Eclipse Tomcat 서버 실행
4. index.jsp에서 이미지 업로드
"""

from flask import Flask, request, jsonify
import cv2
import mediapipe as mp
import math
import os

app = Flask(__name__)

mp_pose = mp.solutions.pose
mp_drawing = mp.solutions.drawing_utils


def calculate_angle(a, b, c):
    """
    세 점 a, b, c를 이용해서 b 지점을 중심으로 각도를 계산한다.
    a, b, c는 각각 [x, y] 형태이다.
    """
    ax, ay = a
    bx, by = b
    cx, cy = c

    radians = math.atan2(cy - by, cx - bx) - math.atan2(ay - by, ax - bx)
    angle = abs(radians * 180.0 / math.pi)

    if angle > 180:
        angle = 360 - angle

    return round(angle, 2)


def make_feedback(style_type, pose_name, shoulder_angle, elbow_angle, knee_angle):
    """
    각도 값을 기준으로 간단한 자세 피드백을 만든다.
    지금 기준값은 임시값이라 프로젝트 기준에 맞게 수정하면 된다.
    """
    feedback = []

    if style_type == "KENDO":
        if shoulder_angle < 70:
            feedback.append("어깨가 너무 내려가 있습니다.")
        elif shoulder_angle > 140:
            feedback.append("어깨가 너무 올라가 있습니다.")
        else:
            feedback.append("어깨 각도는 양호합니다.")

        if elbow_angle < 80:
            feedback.append("팔꿈치가 너무 굽혀져 있습니다.")
        elif elbow_angle > 170:
            feedback.append("팔이 너무 펴져 있습니다.")
        else:
            feedback.append("팔꿈치 각도는 양호합니다.")

        if knee_angle < 100:
            feedback.append("무릎이 너무 굽혀져 있습니다.")
        elif knee_angle > 170:
            feedback.append("무릎이 너무 펴져 있습니다.")
        else:
            feedback.append("무릎 각도는 양호합니다.")

    else:
        # 리히테나워 검술은 자세마다 기준이 달라질 수 있다.
        # 여기서는 기본 예시 기준만 넣어두었다.
        if shoulder_angle < 60:
            feedback.append("상체와 어깨 라인이 낮습니다.")
        elif shoulder_angle > 150:
            feedback.append("상체와 어깨 라인이 과하게 올라갔습니다.")
        else:
            feedback.append("상체와 어깨 라인은 양호합니다.")

        if elbow_angle < 70:
            feedback.append("팔이 너무 접혀 있습니다.")
        elif elbow_angle > 175:
            feedback.append("팔이 너무 완전히 펴져 있습니다.")
        else:
            feedback.append("팔 각도는 양호합니다.")

        if knee_angle < 95:
            feedback.append("하체 자세가 너무 낮습니다.")
        elif knee_angle > 175:
            feedback.append("하체가 너무 펴져 있습니다.")
        else:
            feedback.append("하체 자세는 양호합니다.")

    return " ".join(feedback)


@app.route("/analyze", methods=["POST"])
def analyze():
    try:
        data = request.get_json()

        file_path = data.get("filePath")
        style_type = data.get("styleType")
        pose_name = data.get("poseName")

        if not file_path or not os.path.exists(file_path):
            return jsonify({
                "success": False,
                "errorMessage": "이미지 파일 경로를 찾을 수 없습니다."
            })

        image = cv2.imread(file_path)

        if image is None:
            return jsonify({
                "success": False,
                "errorMessage": "이미지를 읽을 수 없습니다."
            })

        image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        with mp_pose.Pose(static_image_mode=True, min_detection_confidence=0.5) as pose:
            results = pose.process(image_rgb)

            if not results.pose_landmarks:
                return jsonify({
                    "success": False,
                    "errorMessage": "사람 자세를 찾지 못했습니다. 전신이 보이는 사진을 사용해주세요."
                })

            landmarks = results.pose_landmarks.landmark

            # 오른쪽 기준 관절 좌표
            shoulder = landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value]
            elbow = landmarks[mp_pose.PoseLandmark.RIGHT_ELBOW.value]
            wrist = landmarks[mp_pose.PoseLandmark.RIGHT_WRIST.value]
            hip = landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value]
            knee = landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value]
            ankle = landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value]

            shoulder_point = [shoulder.x, shoulder.y]
            elbow_point = [elbow.x, elbow.y]
            wrist_point = [wrist.x, wrist.y]
            hip_point = [hip.x, hip.y]
            knee_point = [knee.x, knee.y]
            ankle_point = [ankle.x, ankle.y]

            shoulder_angle = calculate_angle(hip_point, shoulder_point, elbow_point)
            elbow_angle = calculate_angle(shoulder_point, elbow_point, wrist_point)
            knee_angle = calculate_angle(hip_point, knee_point, ankle_point)

            feedback = make_feedback(style_type, pose_name, shoulder_angle, elbow_angle, knee_angle)

            # 분석 결과 관절선을 이미지에 그린다.
            mp_drawing.draw_landmarks(
                image,
                results.pose_landmarks,
                mp_pose.POSE_CONNECTIONS
            )

            result_path = file_path.replace(".", "_result.")
            cv2.imwrite(result_path, image)

            return jsonify({
                "success": True,
                "shoulderAngle": shoulder_angle,
                "elbowAngle": elbow_angle,
                "kneeAngle": knee_angle,
                "resultImagePath": result_path,
                "feedback": feedback,
                "errorMessage": ""
            })

    except Exception as e:
        return jsonify({
            "success": False,
            "errorMessage": str(e)
        })


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
