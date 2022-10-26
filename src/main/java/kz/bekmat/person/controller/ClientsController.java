package kz.bekmat.person.controller;

import kz.bekmat.person.model.Person;
import kz.bekmat.person.service.PersonService;
import kz.bekmat.person.util.PersonErrorResponse;
import kz.bekmat.person.util.PersonNotCreatedException;
import kz.bekmat.person.util.PersonNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;



@RestController
@RequestMapping("/clients")
public class ClientsController {
    private final PersonService personService;

    @Autowired
    public ClientsController(PersonService personService) {
        this.personService = personService;
    }

    @GetMapping()
    public List<Person> getAllPerson() {
        return personService.findAll();
    }

    @GetMapping("/{id}")
    public Person getPerson(@Valid @PathVariable("id") int id) {
        return personService.findById(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deletePerson(@PathVariable("id") int id) {
        personService.deletePerson(id);
        return ResponseEntity.ok(HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<HttpStatus> createPerson(@RequestBody @Valid Person personToAdd) {
        personService.findByIin(personToAdd.getIin());
        personService.createPerson(personToAdd);
        return ResponseEntity.ok(HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<HttpStatus> updatePerson(@RequestBody Person personToUpdated, BindingResult bindingResult, @Valid @PathVariable("id") int id) {
        personService.findById(id);
        personService.updatePerson(id, personToUpdated);
        return ResponseEntity.ok(HttpStatus.OK);
    }

    @ExceptionHandler
    private ResponseEntity<PersonErrorResponse> handleException(PersonNotFoundException e) {
        PersonErrorResponse response = new PersonErrorResponse(
                "id - Нету зарегистрирванного физического лица с таким ID", LocalDateTime.now());
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler
    private ResponseEntity<PersonErrorResponse> handleException(PersonNotCreatedException e) {
        PersonErrorResponse response = new PersonErrorResponse(
                "iin - Уже есть физическое лицо с таким ИИН",  LocalDateTime.now());
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }
}
