package com.kendo.controller.web;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.kendo.model.PoseDTO.AiRequest;

public class Aicontroller {

	@RestController
	@RequestMapping("/ai")
	public class AiController {

	    @Autowired
	    private AiService aiService;

	    @PostMapping("/predict")
	    public String predict(@RequestBody AiRequest request) {

	        String result = aiService.requestAi(
	                request.getMode(),
	                request.getImage()
	        );

	        return result;
	    }
	}
}
