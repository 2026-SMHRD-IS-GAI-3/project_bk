# Python Flask + MediaPipe/OpenCV 연동용 예시 파일
# Java 웹 프로젝트와 별도로 실행해야 한다.

from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/analyze', methods=['POST'])
def analyze():
    # 실제 구현 시 이미지 파일을 받아서 OpenCV + MediaPipe로 분석한다.
    return jsonify({
        'shoulderAngle': 90.0,
        'elbowAngle': 120.0,
        'kneeAngle': 150.0,
        'result': '임시 분석 결과입니다.'
    })

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)
