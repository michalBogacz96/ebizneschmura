package com.example.app.constroller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloController {

   @GetMapping("/")
    fun helloWorld() : String = "Hello world"
}