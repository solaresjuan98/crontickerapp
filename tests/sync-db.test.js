const { syncDB } = require("../tasks/sync-db")


describe('Test in Sync-DB', () => {

    test('should execute the process twice', () => {
        syncDB();
        const times = syncDB();

        expect(times).toBe(10);

    });



})