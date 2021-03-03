import { interval, timer, of, concat, merge, Subject, BehaviorSubject, AsyncSubject, ReplaySubject } from 'rxjs';
import {map, throttle, throttleTime} from 'rxjs/operators';

// 1
const interval$ = interval(1000);
const timer$ = timer(2000, 1000);

// interval$.subscribe(val => console.log('val', val));
// timer$.subscribe(val => console.log('val of timer', val));

// 2
const source1$ = of(1,3,4);
const source2$ = of(5,3,4);
const source3$ = of(9,3,4);

const result$ = concat(source1$, source2$, source3$);
// result$.subscribe(val => console.log('result val', val));

//3
const interval1$ = interval(1000);
const interval2$ = interval$.pipe(
    map(val => val * 10)
)

const resultmerge$ = merge(interval1$, interval2$);
// resultmerge$.subscribe(console.log);

//4
const interval4$ = interval(1000);

// interval4$.pipe(
//     throttle(() => interval(2000))
// ).subscribe(console.log);

interval4$.pipe(
    throttleTime(4000)
).subscribe(console.log);

// 5 
const sub$ = new Subject();
const subscribe = sub$.asObservable();
subscribe.subscribe(console.log); // early subscribe
sub$.next(1);
sub$.next(1);
sub$.next(1);
sub$.complete();

// 6
const bsub$ = new BehaviorSubject(0);
const subscribe2 = bsub$.asObservable();
bsub$.next(1);
bsub$.next(1);
bsub$.next(1);
subscribe2.subscribe(console.warn); // at any time subscribe

//7
const asub$ = new AsyncSubject();
const subscribe3 = asub$.asObservable();
asub$.next(1);
asub$.next(1);
asub$.next(1);
asub$.complete();
subscribe3.subscribe(console.warn); // emit only last value before complete

//8
const rsub$ = new ReplaySubject();
const subscribe4 = rsub$.asObservable();
rsub$.next(1);
rsub$.next(1);
rsub$.next(1);
rsub$.complete();
subscribe4.subscribe(console.warn); // emit old values to new subscriber