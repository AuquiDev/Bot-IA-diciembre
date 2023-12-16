'use strict';

/**
 * open-ai-assistant service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::open-ai-assistant.open-ai-assistant');
