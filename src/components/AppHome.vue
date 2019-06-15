<template>
  <div class="container bg">
    <div class="row" style="justify-content:center;">
      <h1>Howdy adventurer,</h1>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <h2>What is the <span class="badge badge-pill badge-info">{{task.data.tgtWordFormLbl}}</span> form of</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <h2><span class="badge badge-pill badge-info">{{task.data.srcWordKanjiLbl}}</span></h2>
      </div>
    </div>
    <div class="row" v-show="showSpoiler">
      <div class="col-sm-6 offset-sm-3 text-center">
        <span class="text-muted font-italic">{{task.data.srcWordTrnsLbl}} - {{task.data.srcWordRentaikeiLbl}} ({{task.data.srcWordHiraganaLbl}})</span>
      </div>
    </div>

    <div class="form-text"></div>


    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
        <button type="button" class="btn btn-outline-warning btn-sm" v-on:click='showSpoiler = !showSpoiler'>{{showSpoiler ? 'Hide' : 'Show'}} spoiler</button>
      </div>
    </div>

    <div class="row">
      <div class="col-sm-6 offset-sm-3 text-center">
<form>
        <fieldset :disabled="task.done">
        <div class="form-group">
<!--          <div class="form-group"> -->
            <input class="form-control form-control-lg" v-bind:class="{ 'is-invalid': task.fail, 'is-valid': task.success }" type="text" v-model="answer" @input="validate">
          </div>
<!--        </div> -->
</fieldset>
</form>
</div>
    </div>

    <div class="form-text"></div>

    <div class="row">
      <div class="col-sm-2 offset-sm-3 text-center" v-show="!task.done">
        <button type="button" class="btn btn-danger" v-on:click="giveUp()">Show solution</button>
      </div>

      <div class="col-sm-2 offset-sm-3 text-center" v-show="task.done">
        <button type="button" class="btn btn-success" v-on:click="newTask()">Next</button>
      </div>

    </div>


  </div>
</template>

<script>
export default {
  name: 'AppHome',
  data() {
    return {
      task: {data: {}},
      showSpoiler: false,
      answer: ''
    };
  },
  created() {
    this.newTask();
  },
  methods: {
    newTask() {
      while(this.task.done) {
        this.newTaskCore();
      }
    },

    // Sometimes it happens that a task is immediately solved, in that case just generate a new one
    newTaskCore() {
      this.task.data = pickTask();
      this.task.done = false;
      this.task.fail = false;
      this.task.success = false;
      this.answer = this.task.data.srcWordKanjiLbl;
      this.validate();
    },

    giveUp() {
      this.answer = this.task.data.tgtWordLbl;
      this.task.done = true;
      this.task.fail = true;
    },

    validate() {
     if(this.answer == this.task.data.tgtWordLbl) {// || this.answer == 'test') {
       this.task.done = true;
       this.task.success = true;
     }
    }
  }
};

import data from './data.json';

function pickTask() {
  let n = data.length;

  // Derive schema from first row and remove unwanted keys (somewhat hacky)
  let tmp = data[0];
  let reject = {'id': true, 'id_type': true, 'german': true, 'hiragana': true };
  let schema = Object.getOwnPropertyNames(tmp).filter(x => !reject[x]);

  let m = schema.length;

  // Pick an entry from the table
  let rowIdx = Math.floor((Math.random() * n));
  let row = data[rowIdx];

  // Pick a source
  let srcColIdx = Math.floor((Math.random() * m));
  let tgtColIdx;
  do {
    tgtColIdx = Math.floor((Math.random() * m));
  } while(srcColIdx == tgtColIdx)

  let srcCol = schema[srcColIdx];
  let tgtCol = schema[tgtColIdx];

  console.log('tgtCol', tgtCol, tgtColIdx, m, schema);
 
  let result = {
    srcWordKanjiLbl: row[srcCol][0],
    srcWordHiraganaLbl: row['hiragana'][0],
    srcWordRentaikeiLbl: row['rentaikei'][0],
    srcWordFormLbl: srcCol,
    srcWordTrnsLbl: row['german'][0],
    tgtWordLbl: row[tgtCol][0],
    tgtWordFormLbl: tgtCol
  };

  console.log("Task", result);
  return result;
}




</script>

<style>
    body {
      background: url("japan-chureito-pagode-mount_fuji.jpg") no-repeat center center fixed;
    }

    h1  {
        color: white;
        justify-content:center;
    }
</style>
