package pages.pageLib;

import com.codeborne.selenide.SelenideElement;
import io.cucumber.datatable.DataTable;
import pages.PageManager;

import java.util.Map;

public class SelectAddressPage extends BasePage {
  // Constructor
  public SelectAddressPage(){
    addElement("addAddress", "button[aria-label='Add a new address']");
    addElement("radioButton", "mat-radio-button[class*=mat-radio-button]");
    addElement("continue", "button[aria-label='Proceed to payment selection']");
    addElement("timTester", "//mat-row[contains(., 'Tim Tester')]//mat-radio-button");
    addElement("addNewAddress", "button[aria-label='Add a new address']");
    addElement("country", "input[placeholder='Please provide a country.']");
    addElement("name", "input[placeholder='Please provide a name.']");
    addElement("mobileNumber", "input[placeholder='Please provide a mobile number.']");
    addElement("zipCode", "input[placeholder='Please provide a ZIP code.']");
    addElement("address", "textarea[id='address']");
    addElement("city", "input[placeholder='Please provide a city.']");
    addElement("state", "input[placeholder='Please provide a state.']");
    addElement("submit", "button[id='submitButton']");
  }
  // Methods
  @Override
  public SelenideElement getMainElement() {
    return getElement("addAddress");
  }
  @Override
  public void navigate(String element) {
    switch (element){
      case "continue": PageManager.setCurrentPage(PageManager.getDeliveryPage()); break;
      default        : super.navigate(element);
    }
  }
  @Override
  public void doAction(String action, DataTable dataTable) {
    switch (capitalizeSecond(action)){
      case "validateAddress": validateAddress(dataTable); break;
      default                     : super.doAction(action, dataTable);
    }
  }
  public void validateAddress(DataTable dataTable) {
    Map<String,String> data = dataTable.transpose().asMaps().get(0);
    info("Validating address with the following data:\n" + data);
    if(data.get("Name") != null){
      validateText(data.get("Name"));
    }
    if(data.get("Address") != null){
      validateText(data.get("Address"));
    }
    if(data.get("Country") != null){
      validateText(data.get("Country"));
    }
  }
}
