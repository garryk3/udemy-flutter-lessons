import Store from './store.service';

class StoreUser {
    private store = new Store();

    constructor() {
        this.store.init();
    }
}