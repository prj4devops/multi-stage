package com.prj4devops;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
public class SampleController {

    @RequestMapping("/hello")
    public Map<String, String> hello(HttpServletRequest request){
        Map<String, String> result = new HashMap<>();
        result.put("src", request.getRemoteAddr());
        result.put("dest", request.getServerName());
        return result;
    }
}
