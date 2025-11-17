package com.example.chat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ChatController {

    @GetMapping("/")
    public String index() {
        return "index"; // /WEB-INF/views/index.jsp
    }

    @GetMapping("/chat")
    public String chat(@RequestParam("nick") String nick, Model model) {
        model.addAttribute("nick", nick);
        return "chat"; // /WEB-INF/views/chat.jsp
    }
}
