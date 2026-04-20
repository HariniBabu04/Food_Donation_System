<%@ include file="/WEB-INF/common/header.jsp" %>

<div class="container-fluid min-vh-100 d-flex justify-content-center align-items-center bg-light">
    <div class="w-100 w-md-75 w-lg-50">

        <!-- Back Button centered horizontally -->
        <div class="mb-3 text-start">
            <button type="button" class="btn btn-outline-secondary" onclick="history.back();">
                &larr; Back
            </button>
        </div>

        <h2 class="text-center text-success mb-4">Jarvis AI Assistant</h2>

        <div id="chat-container" class="bg-white p-4 shadow rounded">

            <div id="chat-box" class="mb-3" style="min-height: 300px; max-height: 500px; overflow-y: auto;"></div>

            <div class="d-flex gap-2">
                <input type="text" id="message" class="form-control" placeholder="Ask Jarvis..." />
                <button class="btn btn-success" onclick="sendMessage()">Send</button>
            </div>

        </div>

    </div>
</div>

<%@ include file="/WEB-INF/common/footer.jsp" %>