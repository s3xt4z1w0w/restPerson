package kz.bekmat.person.service;

import kz.bekmat.person.GetTransactionAPI.Order;
import kz.bekmat.person.model.Person;
import kz.bekmat.person.model.Profile;
import kz.bekmat.person.repository.PersonRepository;
import kz.bekmat.person.repository.ProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class ProfileService {
    private final PersonRepository personRepository;
    private final ProfileRepository profileRepository;

    @Autowired
    public ProfileService(PersonRepository personRepository, ProfileRepository profileRepository) {
        this.personRepository = personRepository;
        this.profileRepository = profileRepository;
    }

    @Transactional
    public Person saveResponse(List<Order> orderList, String iin) {

        Person person = personRepository.findByIin(iin);
        List<Profile> profileList = new ArrayList<>();

        for (int i = 0, j = 0; i < orderList.size(); i++) {
            String orderContractNumber = orderList.get(i).getContractNumber();
            Profile checkProfile = profileRepository.findByContractNumber(orderContractNumber);
            if (checkProfile == null) {
                profileList.add(new Profile());
                profileList.get(j).setClient(person);
                profileList.get(j).setContractNumber(orderList.get(i).getContractNumber());
                profileList.get(j).setTypeOfDiscount(orderList.get(i).getTypeOfDiscount());
                profileList.get(j).setHaveDiscount(orderList.get(i).isHaveDiscount());
                profileRepository.save(profileList.get(j)); // Если в данных из API уже присутствуют дубликаты
                j++;
            }
        }
        //profileRepository.saveAll(profileList); //Если нет дубликатов
        return person;
    }
}
