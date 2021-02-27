import React, {useEffect, useState} from 'react';
import { fromEvent } from 'rxjs';
import './App.css';
import Form from './Form';
import useHttp from './use-http';
interface ITodo {
  title: string;
}

const DEFAULT_URL = 'https://jsonplaceholder.typicode.com/todos';

function App() {
   const [url, setUrl] = useState(`${DEFAULT_URL}/1`);
  const { result: tasks, error } = useHttp<ITodo>(url);
  const onClick = () => {}

  useEffect(() => {
    const event$ = fromEvent(document, 'click');
    const interval = setInterval(() => {
      setUrl(lastUrl => {
        const lastId = lastUrl.slice(-1);
        return `${DEFAULT_URL}/${Number(lastId) + 1}`
      })
    }, 100000);

    return () => clearInterval(interval);

    // const subscribe = event$.subscribe(
    //   val => console.log('evt', val),
    //   err => console.error(err),
    //   () => console.log('completed')
    // );

    // return () => {
    //   subscribe.unsubscribe();
    // }
  }, []);
console.log('iii', tasks, error);
  return (
    <div className="App">
      <header className="App-header">
        <Form />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
          onClick={onClick}
        >
          Tasks : {tasks?.title ?? ''} <br/>
          Tasks error : {error ?? 'null'}
        </a>
      </header>
    </div>
  );
}

export default App;
