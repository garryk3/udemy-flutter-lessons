import { useEffect, useState } from 'react';
import { Observable, of, timer } from 'rxjs';
import { tap, delay, shareReplay, catchError, map, retryWhen, delayWhen } from 'rxjs/operators';

export interface IResult<T> {
  error: Error | null;
  result: T | null;
}

export function createHttpObservable<T>(url = 'https://jsonplaceholder.typicode.com/todos') {
  const controller = new AbortController();
  const signal = controller.signal;

  return new Observable<IResult<T>>((subscriber) => {
    fetch(url, {signal})
    .then(response => {
      if(response.ok) {
        return response.json();
      }
      subscriber.error('server error')
    })
    .then(json => {
      subscriber.next({
        result: json,
        error: null
      });
      subscriber.complete();
    })
    .catch((error) => {
      subscriber.next({
        result: null,
        error: error.message
      });
      subscriber.complete();
    }) 

    return () => {
      console.log('cancel request');
      controller.abort();
    };
  });
}

export default function useHttp<T>(url: string) {
    const [val, setVal] = useState<IResult<T>>({result: null, error: null});
    
    useEffect(() => {
        const http$ = createHttpObservable<T>(url)
          .pipe(
            tap(() => console.log('http request execute!')),
            retryWhen(error => error.pipe(
                delayWhen(() => timer(2000))
            ))
          );
    
        const subscription = http$.subscribe((val) => setVal(val));
        return () => {
            subscription.unsubscribe();
        }
      }, [url]);

      return val;
}