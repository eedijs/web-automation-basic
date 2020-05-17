package stepdefinitions;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import static com.codeborne.selenide.Browsers.CHROME;
import static com.codeborne.selenide.Selenide.*;
import static com.codeborne.selenide.WebDriverRunner.clearBrowserCache;

public class Hooks {
  Process juiceShopProcess;
  ProcessBuilder processBuilder = new ProcessBuilder();
  @Before
  public void setUp(){
    killJuiceShop();
    startJuiceShop();
    System.setProperty("selenide.browser", CHROME);
    open("");
  }
  @After
  public void cleanUp(){
    clearJuiceShop();
    clearBrowserCache();
    clearBrowserCookies();
    clearBrowserLocalStorage();
  }
  // Juice Shop methods
  private void startJuiceShop(){
    // Clearing node's just in case any is running in the background.
    killJuiceShop();
    try {
      juiceShopProcess = processBuilder.command("bash", "-c", "cd ../juice-shop ; npm start").start();
      BufferedReader br = new BufferedReader(new InputStreamReader(juiceShopProcess.getInputStream()));
      String line = "";
      while((line = br.readLine()) != null) {
        System.out.println(line);
        if(line.contains("listening")){ return; }
        if(line.toLowerCase().contains("warn")){ throw new Error("Failed to set up Juice Shop"); }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
  private void clearJuiceShop(){
    killJuiceShop();
    for(int i = 0; i < 25; i++){
      if(juiceShopProcess.isAlive()){
        sleep(400);
      }else {
        return;
      }
    }
    throw new Error("Failed to kill node server");
  }
  private void killJuiceShop(){
    try {
//      processBuilder.command("bash", "-c", "killall -9 node").start(); // Didn't work on Windows 10
      processBuilder.command("taskkill", "/f", "/im", "node.exe").start(); // Windows 10 command to kill node.exe
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
