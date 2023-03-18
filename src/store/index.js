import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex);


const hostObj = {
    namespaced: true,
    state: {
        host: [],
    },
    mutations: {

    },
    actions: {

    },
    getters: {

    }
}
const shopcarObj = {
    namespaced: true,
    state: {
        tickets: [],
        total: 0,
        orderitems: [],
    },
    actions: {
        addtickets(context, value) {
            context.commit('ADDTICKETS', value);
        },
        increase(context, value) {
            context.commit('INCREASE', value);
        },
        decrease(context, value) {
            context.commit('DECREASE', value);
        },
        clear(context, value) {
            context.commit('CLEAR', value);
        },
        checked(context, value) {
            context.commit('CHECKED', value);
        },
        checkall(context, value) {
            context.commit('CHECKALL', value);
        },
    },
    mutations: {
        ADDTICKETS(state, value) {
            console.log('value', value);
            if (state.tickets) {
                let res1 = state.tickets.find(ticket => ticket.contentid === value.contentid);
                if (res1) {
                    let res2 = res1.children.find(children => children.ticketid === value.ticketid);
                    if (res2) {
                        res2.num++;
                    } else {
                        res1.children.push({
                            ticketid: value.ticketid,
                            num: value.num,
                            price: value.price,
                            check: false,
                            classify: value.classify
                        })
                    }
                } else {
                    state.tickets.push({
                        contentid: value.contentid,
                        title: value.title,
                        img: value.img,
                        children: [{
                            ticketid: value.ticketid,
                            num: value.num,
                            price: value.price,
                            check: false,
                            classify: value.classify
                        }]
                    });
                }
            } else {
                state.tickets.push(value);
            }
        },
        INCREASE(state, value) {
            // console.log('INCREASE :state', state, 'value', value);
            let increase1 = state.tickets.find(ticket => ticket.contentid === value.contentid);
            if (increase1) {
                let increase2 = increase1.children.find(children => children.ticketid === value.ticketid);
                if (increase2.check) {
                    state.total += increase2.price;
                }
                if (increase2 && increase2.num >= 0) {
                    increase2.num++;
                }
            }
        },
        DECREASE(state, value) {
            // console.log('DECREASE :state', state, 'value', value);
            let decrease1 = state.tickets.find(ticket => ticket.contentid === value.contentid);
            if (decrease1) {
                let decrease2 = decrease1.children.find(children => children.ticketid === value.ticketid);
                if (decrease2.check && decrease2.num > 1) {
                    state.total -= decrease2.price;
                }
                if (decrease2.num > 1) {
                    decrease2.num--;
                }
            }
        },
        CLEAR(state, value) {
            console.log('state', state);
            for (let i = state.tickets.length - 1; i >= 0; i--) {
                if (state.tickets[i].contentid === value.contentid) {
                    for (let j = state.tickets[i].children.length - 1; j >= 0; j--) {
                        if (state.tickets[i].children[j].ticketid === value.ticketid) {
                            if (state.tickets[i].children[j].check === true) {
                                state.total = state.total - state.tickets[i].children[j].num * state.tickets[i].children[j].price;
                                state.tickets[i].children.splice(j, 1);
                            }
                            if (state.tickets[i].children.length === 0) {
                                state.tickets.splice(i, 1);
                            }
                        }
                    }
                }
            }
            /* for (let i = 0; i < state.tickets.length; i++) {
                let ticket = state.tickets[i];
                if (ticket.contentid === value.contentid) {
                    for (let j = 0; j < ticket.children.length; j++) {
                        let child = ticket.children[j];
                        if (child.ticketid === value.ticketid) {
                            if (child.check === true) {
                                state.total -= child.num * child.price;
                                ticket.children.splice(j, 1);
                                j--;
                                if (ticket.children.length === 0) {
                                    state.tickets.splice(i, 1);
                                    i--;
                                }
                            }
                        }
                    }
                }
            } */
            /* let clear1 = state.tickets.find(ticket => ticket.contentid === value.contentid);
            let clear1index = state.tickets.findIndex(ticket => ticket.contentid === value.contentid);
            if (clear1) {
                let clear2 = clear1.children.find(children => children.ticketid === value.ticketid);
                let clear2index = clear1.children.findIndex(children => children.ticketid === value.ticketid);
                if (clear2index > -1) {
                    if (clear2.check) {
                        state.total -= clear2.num * clear2.price;
                        clear1.children.splice(clear2index, 1);
                        if (clear1.children.length!==0) {
                            state.tickets.splice(clear1index, 1);
                        }
                    }
                    console.log('clea1',clear1,'clea1index',clear1index,'clear2',clear2,'clear2index',clear2index)
                }
            } */
        },
        CHECKED(state, value) {
            // console.log('CHECKED :state', state, 'value', value);
            let checked1 = state.tickets.find(ticket => ticket.contentid === value.contentid);
            if (checked1) {
                let checked2 = checked1.children.find(children => children.ticketid === value.ticketid);
                if (checked2.num >= 1) {
                    checked2.check = value.checked;
                    if (checked2.check) {
                        state.total += checked2.num * checked2.price;
                    } else {
                        state.total -= checked2.num * checked2.price;
                    }
                }
            }

        },
        CHECKALL(state, value) {
            if (value === false) {
                state.total = 0;
            }
            for (let i = 0; i < state.tickets.length; i++) {
                let tickets = state.tickets[i];
                if (tickets.children) {
                    for (let j = 0; j < tickets.children.length; j++) {
                        let children = tickets.children[j];
                        if (value) {
                            children.check = false;
                            state.total -= children.num * children.price;
                        } else {
                            children.check = true;
                            state.total += children.num * children.price;
                        }
                    }
                }
            }
        },
    },
    getters: {

    }
}


export default new Vuex.Store({
    modules: {
        hostObj: hostObj,
        shopcarObj: shopcarObj,
    }
})