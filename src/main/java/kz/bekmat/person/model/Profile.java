package kz.bekmat.person.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name = "profile")
public class Profile {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @NotEmpty
    @Column(name = "contract_number", unique = true)
    private String contractNumber;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "client", referencedColumnName = "id")
    private Person client;

    @Column(name = "is_have_discount")
    private boolean isHaveDiscount;

    @Column(name = "type_discount")
    private String typeOfDiscount;

    public Profile() {
    }

    public Profile(String contractNumber, boolean isHaveDiscount, String typeOfDiscount) {
        this.contractNumber = contractNumber;
        this.isHaveDiscount = isHaveDiscount;
        this.typeOfDiscount = typeOfDiscount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public Person getClient() {
        return client;
    }

    public void setClient(Person client) {
        this.client = client;
    }

    public boolean isHaveDiscount() {
        return isHaveDiscount;
    }

    public void setHaveDiscount(boolean haveDiscount) {
        isHaveDiscount = haveDiscount;
    }

    public String getTypeOfDiscount() {
        return typeOfDiscount;
    }

    public void setTypeOfDiscount(String typeOfDiscount) {
        this.typeOfDiscount = typeOfDiscount;
    }

    @Override
    public String toString() {
        return "Profile{" +
                "id=" + id +
                ", contractNumber='" + contractNumber + '\'' +
                ", isHaveDiscount=" + isHaveDiscount +
                ", typeOfDiscount='" + typeOfDiscount + '\'' +
                '}';
    }
}
