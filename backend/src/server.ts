import type { Request, Response } from 'express';
const express = require('express');

const app = express();
const port = 3000;

app.get('/', (req: Request, res: Response) => {
  res.send('Olá, mundo!');
});

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
