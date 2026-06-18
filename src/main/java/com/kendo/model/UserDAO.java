package com.kendo.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.kendo.database.SqlSessionManager;

import com.kendo.model.TrainingDTO;
import java.util.Map;

/*
 * 회원 DB 작업을 담당하는 DAO 클래스
 *
 * Controller 또는 Servlet은 DB에 직접 접근하지 않고
 * DAO 메서드를 호출해서 회원가입, 로그인, 조회를 처리한다.
 */
public class UserDAO {

    // MyBatis 연결 객체를 만들어주는 팩토리
    private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getFactory();

    /*
     * 회원가입
     * UserMapper.xml의 join SQL을 실행한다.
     */
    public int join(UserDTO dto) {

        SqlSession sqlSession = null;
        int result = 0;

        try {
            // true는 SQL 실행 후 자동 commit을 의미한다.
            sqlSession = sqlSessionFactory.openSession(true);

            // namespace.id 형식으로 Mapper SQL 호출
            result = sqlSession.insert("UserMapper.join", dto);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }

    /*
     * 로그인
     * ID와 PW가 일치하는 회원이 있으면 UserDTO를 반환한다.
     * 없으면 null이 반환된다.
     */
    public UserDTO login(UserDTO dto) {

        SqlSession sqlSession = null;
        UserDTO loginUser = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);
            loginUser = sqlSession.selectOne("UserMapper.login", dto);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return loginUser;
    }

    /*
     * 아이디 중복 체크
     * 같은 ID가 있으면 1 이상, 없으면 0이 나온다.
     */
    public int checkId(String id) {

        SqlSession sqlSession = null;
        int count = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);
            count = sqlSession.selectOne("UserMapper.checkId", id);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return count;
    }

    /*
     * 전체 회원 조회
     */
    public List<UserDTO> selectAllUser() {

        SqlSession sqlSession = null;
        List<UserDTO> list = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);
            list = sqlSession.selectList("UserMapper.selectAllUser");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return list;
    }
    
    /*
     * 비밀번호 재설정
     */
    public int resetPassword(UserDTO dto) {

        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);
            result = sqlSession.update("UserMapper.resetPassword", dto);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    public int updateProfileSet(UserDTO dto) {
        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);
            result = sqlSession.update("UserMapper.updateProfileSet", dto);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    public TrainingDTO selectTrainingData(int division, int postureNum) {

        SqlSession sqlSession = null;
        TrainingDTO result = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            java.util.Map<String, Object> param =
                new java.util.HashMap<String, Object>();

            param.put("division", division);
            param.put("postureNum", postureNum);

            result = sqlSession.selectOne(
                "UserMapper.selectTrainingData",
                param
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    public int insertTrainHis(Map<String, Object> param) {
        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.insert(
                "UserMapper.insertTrainHis",
                param
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    public int purchaseGoods(Map<String, Object> param) {
        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.insert(
                "UserMapper.purchaseGoods",
                param
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    public List<Map<String, Object>> pointShopList() {
        SqlSession sqlSession = null;
        List<Map<String, Object>> list = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            list = sqlSession.selectList("UserMapper.pointShopList");

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return list;
    }
    
    public int clearAchievement(Map<String, Object> param) {
        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(false);

            result = sqlSession.insert("UserMapper.insertAchievementClear", param);

            if (result > 0) {
                sqlSession.update("UserMapper.addAchievementPoint", param);
            }

            sqlSession.commit();

        } catch (Exception e) {
            e.printStackTrace();

            if (sqlSession != null) {
                sqlSession.rollback();
            }

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    public Map<String, Object> selectMyPageStats(int mNum) {

        SqlSession sqlSession = null;
        Map<String, Object> result = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.selectOne(
                "UserMapper.selectMyPageStats",
                mNum
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    
    public List<Map<String, Object>> selectChallengeTrainHistory(int mNum) {

        SqlSession sqlSession = null;
        List<Map<String, Object>> result = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.selectList(
                "UserMapper.selectChallengeTrainHistory",
                mNum
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    public int updateTrainingGrade(Map<String, Object> param) {

        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.update(
                "UserMapper.updateTrainingGrade",
                param
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    public List<Map<String, Object>> selectOwnedTitles(int mNum) {

        SqlSession sqlSession = null;
        List<Map<String, Object>> result = null;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.selectList(
                "UserMapper.selectOwnedTitles",
                mNum
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    public int updateMemberGoods(UserDTO dto) {

        SqlSession sqlSession = null;
        int result = 0;

        try {
            sqlSession = sqlSessionFactory.openSession(true);

            result = sqlSession.update(
                "UserMapper.updateMemberGoods",
                dto
            );

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return result;
    }
    
    
    
}
