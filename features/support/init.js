const { Request, Storage } = require('e2e-api-cucumber');

const { defineSupportCode } = require('cucumber');
const env = require('dotenv').config({ path: `./config/env/${process.env.AMBIENTE}.env` });

if (env.error) throw env.error;

defineSupportCode(({ Before }) => {
    Storage.setGlobalVariable('ambiente', process.env.FIXTURES_PATH);

    defineSupportCode(({ setDefaultTimeout }) => {
        setDefaultTimeout(60 * 1000); // this is in ms
    });

    Before(() => {
        Request
            .init()
            .setRequestHeader('Content-Type', 'application/json');
    });
    Before({ tags: '@debug' }, () => {
        Request.setDebug(false);
    });

    Before({ tags: '@httpbin' }, () => {
        Request
            .setDomain(process.env.SERVER_URL);
    });
});
