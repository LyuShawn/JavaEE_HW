import com.lqw.pojo.Product;
import org.junit.Test;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

public class MybaitsTest {
    public static void main(String[] args) {

    }

    @Test
    public void testSearchById() throws IOException {
        InputStream in = Resources.getResourceAsStream("MybaitsConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
        SqlSession session = sqlSessionFactory.openSession();
        Product product=session.selectOne("productDao.findProductById",87);
        System.out.println(product);
        session.close();
        in.close();
    }
}
