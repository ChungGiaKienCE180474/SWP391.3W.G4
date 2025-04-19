<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Care Service</title>

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">

            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href="/client/css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="/client/css/style.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />

            <style>
                .message {
                    padding: 10px;
                    margin: 5px;
                    border-radius: 10px;
                    max-width: 70%;
                    word-wrap: break-word;
                }

                .user {
                    background-color: #007bff;
                    color: white;
                    align-self: flex-end;
                    text-align: right;
                    margin-left: auto;
                }

                .bot {
                    background-color: #39a89f;
                    color: black;
                    align-self: flex-start;
                    text-align: left;
                    margin-right: auto;
                }

                #chat-box {
                    display: flex;
                    flex-direction: column;
                }
            </style>

            <div class="chat-container" style="
        position: fixed; 
        top: 50%; 
        left: 50%; 
        transform: translate(-50%, -50%);
        width: 800px; 
        height: 500px; 
        background: rgb(255, 255, 255); 
        padding: 20px; 
        border-radius: 10px; 
        border: 2px solid rgb(85, 165, 145);
        box-shadow: 0 0 15px rgba(0,0,0,0.2);">

                <div id="chat-box" style="
            height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            background: #f9f9f9;">
                </div>

                <div style="display: flex; margin-top: 10px;">
                    <input type="text" id="user-input" class="form-control" placeholder="Enter the message..."
                        onkeypress="handleKeyPress(event)" style="flex: 1; margin-right: 10px;">
                    <button class="btn btn-primary" onclick="sendMessage()">Send</button>
                </div>
            </div>

            <script>
                const API_KEY = "AIzaSyDv6sL4HSQ6uvlPHq8bfoESihK2g0kzJYo";
                const API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

                function sendMessage() {
                    let inputField = document.getElementById("user-input");
                    let message = inputField.value.trim();
                    if (message === "") return;

                    addMessage(message, "user");
                    inputField.value = "";

                    let chatBox = document.getElementById("chat-box");
                    let typingIndicator = document.createElement("div");
                    typingIndicator.classList.add("message", "bot");
                    typingIndicator.textContent = "...";
                    chatBox.appendChild(typingIndicator);
                    chatBox.scrollTop = chatBox.scrollHeight;

                    fetch(API_URL, {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({
                            "contents": [{ "parts": [{ "text": message }] }]
                        })
                    })
                        .then(response => response.json())
                        .then(data => {
                            let botReply = data.candidates[0].content.parts[0].text;
                            // Delay 1.5s before showing bot reply
                            setTimeout(() => {
                                chatBox.removeChild(typingIndicator);
                                addMessage(botReply, "bot");
                            }, 1500); // <-- thời gian delay tại đây
                        })
                        .catch(error => {
                            chatBox.removeChild(typingIndicator);
                            addMessage("Xin lỗi, có lỗi xảy ra!", "bot");
                        });
                }

                function handleKeyPress(event) {
                    if (event.key === "Enter") {
                        sendMessage();
                    }
                }

                function addMessage(text, sender) {
                    let chatBox = document.getElementById("chat-box");
                    let messageDiv = document.createElement("div");
                    messageDiv.classList.add("message", sender);
                    messageDiv.textContent = text;
                    chatBox.appendChild(messageDiv);
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            </script>
        </body>

        </html>