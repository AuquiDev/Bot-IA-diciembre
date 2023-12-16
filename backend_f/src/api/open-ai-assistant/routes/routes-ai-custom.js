
module.exports = {
    routes: [
        {
            method: 'POST',
            path: '/generate/ai',
            handler: 'open-ai-assistant.generateAIAssistant',
        }
    ]
}