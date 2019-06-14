<template>
  <div class="container">
    <div class="row" style="justify-content:center;">
      <h1>Howdy adventurer,</h1>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <h2>What is the <span class="badge badge-pill badge-success">{{task.tgtWordFormLbl}}</span> form of</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <h2><span class="badge badge-pill badge-info">{{task.srcWordLbl}}</span></h2>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <span class="text-muted font-italic">{{task.srcWordTrnsLbl}} - {{task.srcWordFormLbl}}</span>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <input class="form-control form-control-lg" type="text"> <!-- placeholder="Answer" -->
      </div>
    </div>

  </div>
</template>

<script>
export default {
    name: 'AppHome',
    data() {
      return { task: pickTask() };
    }
};

import data from './data.json';

function pickTask() {
  let n = data.length;

  // Derive schema from first row and remove unwanted keys (somewhat hacky)
  let tmp = data[0];
  let reject = {'id': true, 'id_type': true };
  let schema = Object.getOwnPropertyNames(tmp).filter(x => !reject[x]);

  let m = schema.length;

  // Pick an entry from the table
  let rowIdx = Math.floor((Math.random() * n) + 1);
  let row = data[rowIdx];
  console.log(schema, tmp);

  // Pick a source
  let srcColIdx = Math.floor((Math.random() * m) + 1);
  let tgtColIdx;
  do {
    tgtColIdx =  Math.floor((Math.random() * m) + 1);
  } while(srcColIdx == tgtColIdx)

  let srcCol = schema[srcColIdx];
  let tgtCol = schema[tgtColIdx];
  
  let result = {
    srcWordLbl: row[srcCol][0],
    srcWordFormLbl: srcCol,
    srcWordTrnsLbl: row['german'][0],
    tgtWordLbl: row[tgtCol][0],
    tgtWordFormLbl: tgtCol
  };

  return result;
}




</script>

<style scoped>
    h1  {
        color: green;
        justify-content:center;
    }
</style>
