package kz.bekmat.person.repository;

import kz.bekmat.person.model.Profile;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, Integer> {

    Profile findByContractNumber(String contractNumber);

}
