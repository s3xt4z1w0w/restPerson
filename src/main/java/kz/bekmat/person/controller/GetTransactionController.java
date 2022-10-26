package kz.bekmat.person.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import kz.bekmat.person.GetTransactionAPI.GetTransactionApiService;
import kz.bekmat.person.GetTransactionAPI.Order;
import kz.bekmat.person.model.Person;
import kz.bekmat.person.service.PersonService;
import kz.bekmat.person.service.ProfileService;
import kz.bekmat.person.util.PersonErrorResponse;
import kz.bekmat.person.util.PersonNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/get-transaction")
public class GetTransactionController {
    private final GetTransactionApiService getTransactionApiService;
    private final PersonService personService;
    private final ProfileService profileService;

    @Autowired
    public GetTransactionController(GetTransactionApiService getTransactionApiService, PersonService personService, ProfileService profileService) {
        this.getTransactionApiService = getTransactionApiService;
        this.personService = personService;
        this.profileService = profileService;
    }

    @PostMapping()
    public Person getProfile(@RequestBody Person person) throws JsonProcessingException {
        personService.checkIin(person.getIin());
        List<Order> orderList = getTransactionApiService.makePostRequest(person);
        return profileService.saveResponse(orderList, person.getIin());
    }

    @ExceptionHandler
    private ResponseEntity<PersonErrorResponse> handleException(PersonNotFoundException e) {
        PersonErrorResponse response = new PersonErrorResponse(
                "iin - Нету зарегистрирванного физического лица с таким IIN",  LocalDateTime.now());
        System.out.println( LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
    }
}
