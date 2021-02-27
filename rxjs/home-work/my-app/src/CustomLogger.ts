import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

export enum LogLevel {
    TRACE,
    DEBUG,
    INFO,
    ERROR
}

let appLogLevel = LogLevel.INFO;

export const setLogLevel = (level: LogLevel) => {
    appLogLevel = level;
}

export const debug = (level: LogLevel, message: string) => (source: Observable<any>) => source.pipe(
    tap((val) => {
        if(level >= appLogLevel) {
            console.log(`${message}: `, val);
        }
    })
)