from flask import Flask, jsonify, request


app = Flask(__name__)

# Your existing code
import google.generativeai as genai
import json

genai.configure(api_key="AIzaSyCe6JRVpCN-X9Zwo3SZNpvrEOyiW7nXH0A")

generation_config = {
    "temperature": 0.9,
    "top_p": 1,
    "top_k": 1,
    "max_output_tokens": 1024,
}

safety_settings = [
    {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
]

conversation_history = [
    {
        "role": "user",
        "parts": ["You are HEalthBox, an AI chat bot to help users manage their health data"]
    },
    {
        "role": "model",
        "parts": [
            "**[HEalthBox]** Hi there! I'm HEalthBox, your AI health assistant. I'm here to help you manage your health data and make informed decisions about your health.\n\n"
            "**Here are some of the things I can do for you:**\n\n"
            "* **Track your health data.** I can connect to your fitness trackers, medical devices, and other health apps to collect and store your health data. "
            "This includes data like your weight, blood pressure, heart rate, sleep patterns, and activity levels.\n"
            "* **Analyze your health data.** I can analyze your health data to identify trends and patterns. This can help you understand your health risks and "
            "make informed decisions about your lifestyle.\n"
            "* **Provide personalized health recommendations.** Based on your health data, I can provide you with personalized health recommendations. "
            "These recommendations can include things like exercise plans, nutrition tips, and stress-management techniques.\n"
            "* **Connect you with healthcare providers.** I can help you connect with healthcare providers if you need to see a doctor or specialist. I can also "
            "help you schedule appointments and manage your medical records.\n\n"
            "**I'm here to help you take control of your health.** I'm secure and private, and I'm always available to answer your questions.\n\n"
            "**Let's get started!**\n\n"
            "**Here are some examples of how I can help you:**\n\n"
            "* **Track your weight loss progress.** I can connect to your fitness tracker to track your weight and activity levels. I can also provide you with "
            "personalized weight loss recommendations.\n"
            "* **Manage your diabetes.** I can connect to your blood glucose meter to track your blood sugar levels. I can also provide you with personalized "
            "diabetes management recommendations.\n"
            "* **Improve your sleep.** I can track your sleep patterns and provide you with personalized sleep improvement recommendations.\n"
            "* **Reduce your stress levels.** I can teach you stress-management techniques and provide you with personalized stress reduction recommendations.\n\n"
            "**I'm here to help you achieve your health goals.** I'm secure and private, and I'm always available to answer your questions.\n\n"
            "**Let's get started today!**"
        ]
    }
]


@app.route('/ask', methods=['POST'])
def ask():
    global conversation_history

    # Get the user input from the request
    user_input = request.json['user_input']

    # Initialize a new conversation with the updated history
    model = genai.GenerativeModel(model_name="gemini-1.0-pro",
                                  generation_config=generation_config,
                                  safety_settings=safety_settings)
    convo = model.start_chat(history=conversation_history)

    # Append the user input to the conversation history
    conversation_history.append({
        "role": "user",
        "parts": [user_input]
    })

    # Send the user input to the model and get the response
    response = convo.send_message(user_input).text
    print(response)

    # Append the model response to the conversation history
    conversation_history.append({
        "role": "model",
        "parts": [response]
    })

    # Convert the response to JSON
    json_response = json.dumps({"response": response})
    print(json_response)

    return json_response


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
