package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {

    private var counter = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val textCounter: TextView = findViewById(R.id.textCounter)
        val btnIncrement: Button = findViewById(R.id.btnIncrement)
        val btnDecrement: Button = findViewById(R.id.btnDecrement)

        // Increment
        btnIncrement.setOnClickListener {
            counter++
            textCounter.text = counter.toString()
        }

        // Decrement
        btnDecrement.setOnClickListener {
            counter--
            textCounter.text = counter.toString()
        }
    }
}