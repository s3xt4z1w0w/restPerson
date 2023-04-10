package kz.bekmat.alibek;

import lombok.RequiredArgsConstructor;
import org.camunda.bpm.engine.delegate.DelegateExecution;
import org.camunda.bpm.engine.delegate.JavaDelegate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class RecordDelegate implements JavaDelegate {
    private final Repository repository;

    @Override
    public void execute(DelegateExecution delegateExecution) throws Exception {

        delegateExecution.setVariable("Alibek", true);
        repository.updateDeveloper("31", "920707350547");

    }
}
