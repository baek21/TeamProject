package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainMapController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="mainMap/homePage")
	public String homePage() {
		log.info(this.getClass());
		
		return "/mainMap/homePage";
	}
}
