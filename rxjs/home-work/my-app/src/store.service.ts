import { Observable, Subject } from "rxjs";

import { BehaviorSubject } from 'rxjs';
import {tap, map} from 'rxjs/operators';

import {createHttpObservable, IResult} from './use-http';

export default class Store {
    private subject = new BehaviorSubject<IResult<string>>({result: null, error: null});

    prop1: Observable<IResult<string>> = this.subject.asObservable();

    init() {
        const http$ = createHttpObservable<string>();

        http$
            .pipe(
                tap((val) => console.log('req val: ', val))
            )
            .subscribe((val) => {
                this.subject.next(val)
            })
    }

    selectDataWithoutError() {
        return this.prop1.pipe(
            map((val) => val.error !== null)
        )
    }

    selectDataWithError() {
        return this.prop1.pipe(
            map((val) => val.error === null)
        )
    }

    showOnlyFirst() {
        const current = this.prop1Value.result;
        if(!current) {
            return;
        }
        const newData = {
            ...this.prop1Value,
            result: current[0]
        };
        this.subject.next(newData);
    }

    get prop1Value(): IResult<string> {
        return this.subject.getValue();;
    }
}