package kz.bekmat.person.service;

import kz.bekmat.person.model.Person;
import kz.bekmat.person.repository.PersonRepository;
import kz.bekmat.person.util.PersonNotCreatedException;
import kz.bekmat.person.util.PersonNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class PersonService {

    private final PersonRepository personRepository;

    @Autowired
    public PersonService(PersonRepository personRepository) {
        this.personRepository = personRepository;
    }

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    public Person findByIin(String iin) {
        Person person = personRepository.findByIin(iin);
        Optional<Person> checkPerson = Optional.ofNullable(personRepository.findByIin(iin));
        boolean isHaveIin = checkPerson.isPresent();
        if (isHaveIin)
            throw new PersonNotCreatedException("iin - Уже есть физическое лицо с таким ИИН");
        return person;
    }

    public Person checkIin(String iin) {
        Person checkPerson = personRepository.findByIin(iin);
        if (checkPerson == null)
            throw new PersonNotFoundException("iin - Нету зарегистрирванного физического лица с таким IIN");
        return checkPerson;
    }
    public Person findById(int id) {
        Optional<Person> checkPerson = personRepository.findById(id);
        boolean isHaveId = checkPerson.isPresent();
        if (!isHaveId)
            throw new PersonNotFoundException("id - Нету зарегистрирванного физического лица с таким ID");
        return checkPerson.get();
    }
    @Transactional
    public void createPerson(Person person) {
        System.out.println(person);
        personRepository.save(person);
    }
    @Transactional
    public Person updatePerson(int id, Person updatedPerson) {
        boolean isHaveIin = Optional.ofNullable(personRepository
                                    .findByIin(updatedPerson.getIin())).isPresent();
        if (isHaveIin) {
            throw new PersonNotCreatedException("iin - Уже есть физическое лицо с таким ИИН");
        }
        updatedPerson.setId(id);
        personRepository.save(updatedPerson);
        return updatedPerson;
    }

    @Transactional
    public void deletePerson(int id) {
        boolean isHaveId = personRepository.findById(id).isPresent();
        if (isHaveId)
            personRepository.deleteById(id);
        else
            throw new PersonNotFoundException("id - Нету зарегистрирванного физического лица с таким ID");
    }
}
