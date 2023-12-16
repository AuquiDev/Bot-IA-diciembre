'use strict';
const OpenAI = require("openai");
// import OpenAI from "openai";
// import { sleep } from "openai/core";

// @ts-ignore
const openai = new OpenAI({
    apiKey: '', // defaults to process.env["OPENAI_API_KEY"]

});
/**
 * open-ai-assistant controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::open-ai-assistant.open-ai-assistant', (strapi) => ({

    async generateAIAssistant(ctx) {
        // MODELO, MESSAGE
        // @ts-ignore
        const { modelo, message } = ctx.request.body;

        let assistantId = modelo;
        let thread = await openai.beta.threads.create();
        let threadID = thread.id;

        const threadMessages = await openai.beta.threads.messages.create(
            threadID,

            { role: "user", content: message }
        );

        let run = await openai.beta.threads.runs.create(threadID, {
            assistant_id: assistantId,
        });

        while (true) {
            let runStatus = await openai.beta.threads.runs.retrieve(threadID, run.id);
            if (runStatus.status == 'completed') {
                break;
            } else {
                await new Promise(resolve => setTimeout(resolve, 5000));
            }
        }
        let messages = await openai.beta.threads.messages.list(threadID);
        let response = messages.data[0].content[0].text.value;

        return {
            "data":response
        };
    }

}));
