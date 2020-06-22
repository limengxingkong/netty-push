package com.lfx.nettypush.controller;

import com.lfx.nettypush.service.PushService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author lifenxing
 * @date 2020-03-30-20:08
 */
@RestController
@RequestMapping("/push")
public class PushController {

    @Autowired
    private PushService pushService;

    /**
     * 推送给所有用户
     * @param msg
     */
    @PostMapping("/pushAll")
    public void pushToAll(@RequestParam("msg") String msg){
        pushService.pushMsgToAll(msg);
    }
    /**
     * 推送给指定用户
     * @param userId
     * @param msg
     */
    @PostMapping("pushOne")
    public void pushMsgToOne(@RequestParam("userId") String userId,@RequestParam("msg") String msg){
        pushService.pushMsgToOne(userId,msg);
    }

    /**
     * 用户1
     * @return
     */
    @GetMapping("index")
    public ModelAndView getIndex(){
        return new ModelAndView("hello");
    }

    /**
     * 用户2
     * @return
     */
    @GetMapping("index1")
    public ModelAndView getIndex1(){
        return new ModelAndView("hello1");
    }



}
