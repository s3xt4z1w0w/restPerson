package kz.bekmat.person.GetTransactionAPI;

import com.fasterxml.jackson.core.JsonProcessingException;
import kz.bekmat.person.model.Person;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Service
@Transactional
public class GetTransactionApiService {
    public List<Order> makePostRequest(Person person) throws JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/get-orders";

        Order[] result = restTemplate.postForObject(url, person, Order[].class);

        return  Arrays.asList(result);
    }

}
