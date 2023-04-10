package kz.bekmat.alibek;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.util.Optional;

public interface Repository extends JpaRepository<Developer, Integer>{

    @Transactional
    @Modifying
    @Query(nativeQuery = true,
            value = """
                    UPDATE Developer SET age = :age WHERE iin = :iin
                    """)
    void updateDeveloper(@Param("age") String age, @Param("iin") String iin);
}
