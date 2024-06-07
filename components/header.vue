<script setup lang="ts">
</script>

<template>
  <div class="header">
    <div class="left">
      <img src="~/assets/image/logo.jpg" alt="logo">
      <div>素明诚</div>
    </div>
    <div class="center">AI 应用中心</div>
    <div class="right"></div>
  </div>
</template>

<style scoped lang="scss">
.header {
  width: 100%;
  background-color: #fff;
  height: 50px;
  border-bottom: 1px solid #D3DEFF;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .left {
    padding-left: 16px;

    img {
      width: 28px;
      height: 28px;
      float: left;
    }

    div {
      font-size: 14px;
      color: #000;
      margin-left: 10px;
      float: left;
      line-height: 28px;
    }
  }

  .center {
    //font-weight: bold;
    font-size: 14px;
  }
}
</style>
