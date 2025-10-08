package com.example.myapplication2

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val num1: EditText = findViewById(R.id.num1)
        val num2: EditText = findViewById(R.id.num2)
        val btnAdd: Button = findViewById(R.id.btnAdd)
        val txtResult: TextView = findViewById(R.id.txtResult)

        btnAdd.setOnClickListener {
            val number1 = num1.text.toString().toIntOrNull() ?: 0
            val number2 = num2.text.toString().toIntOrNull() ?: 0
            val sum = number1 + number2
            txtResult.text = "Result: $sum"
        }
    }
}