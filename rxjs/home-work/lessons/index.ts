import { interval, timer, of, concat, merge } from 'rxjs';
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