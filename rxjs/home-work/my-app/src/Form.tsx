import React, { useRef, useState, useLayoutEffect } from 'react';
import { fromEvent, Observable, from, of } from 'rxjs';
import { filter, concatMap, exhaustMap, switchMap, delay, tap, map, distinctUntilChanged, debounceTime, catchError, finalize } from 'rxjs/operators';

import { debug, LogLevel, setLogLevel } from './CustomLogger';

export default function Form() {
    const $form = useRef<any>(null);
    const $text = useRef<any>(null);
    const $email = useRef<any>(null);
    const form$ = useRef<Observable<any>>(); 
    const text$ = useRef<Observable<any>>(); 
    const email$ = useRef<Observable<any>>(); 

    const [isValid, setIsValid] = useState(false);
    const [title, setTitle] = useState('absent');

    const loadTask = (index: number) => from(fetch(`https://jsonplaceholder.typicode.com/todos/${index + 1}`).then(res => res.json()));

    useLayoutEffect(() => {
        form$.current = fromEvent($form.current, 'submit');
        text$.current = fromEvent($text.current, 'change');
        email$.current = fromEvent($email.current, 'input');

        const emailSubscription = email$.current
            .pipe(
                map(evt => (evt as any).target.value),
                debounceTime(100),
                distinctUntilChanged(),
                switchMap((val, index) => loadTask(index)),
                debug(LogLevel.INFO, 'log it: '),
                catchError(err => of(err)),
                finalize(() => console.log('final!'))
            )
            .subscribe(console.warn);

        const formSubscription = form$.current.pipe(
            filter(() => $form.current.checkValidity()),
            tap(evt => evt.preventDefault()),
            delay(5000),
            exhaustMap((val, index) => loadTask(index))
        )
        .subscribe((task: any) => {            
            setIsValid($form.current.checkValidity().toString());
            setTitle(task.title);
        });

        return () => {
            emailSubscription.unsubscribe();
            formSubscription.unsubscribe();
        }
    }, []);

    return (
        <div>
            <form style={{display: 'flex', flexDirection: 'column'}} ref={$form} action='get'>
            <input ref={$text} pattern='[A-Z]' required type="text"/>
            <input ref={$email} required type="number"/>
            <input type="submit"/>
        </form>
        <div>form is {isValid.toString()}</div>
        <div>title is {title}</div>
        </div>
    )
}

