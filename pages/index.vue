<script setup lang="ts">
import Header from '@/components/header.vue'
import { useFetch } from "nuxt/app";
import type { AppConfig } from "~/components/type";
import { nanoid } from "nanoid";

const { data, error, pending } = useFetch<AppConfig>('/api/config');

console.log("data", data)
const thisWindowOpens = (url: string) => {
  window.open(url, '_blank')
}
</script>

<template>
  <div class="main">
    <Header></Header>
    <div class="appBody">
      <div class="appList">
        <el-card v-for="item in data?.appList" :key="nanoid()" shadow="hover"
                 @click="thisWindowOpens(item.url)" class="card">
          <div class="card-item">
            <el-image class="elImage" :src="item.icon" fit="fill" loading="lazy"/>
            <div class="contents">
              <div class="name">{{ item.name }}</div>
              <client-only>
                <el-tooltip class="item-tooltip" effect="dark" placement="bottom-start" :content="item.description">
                  <div class="description">
                    {{ item.description }}
                  </div>
                </el-tooltip>
              </client-only>
            </div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.appBody {
  width: 80%;
  margin: 0 auto;
  height: calc(100vh - 100px);
  border-radius: 6px;
  background-color: #fff;

  .appList {
    overflow: hidden;
    padding: 10px;
    height: 100%;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
    //grid-auto-rows: minmax(100px, auto); // 使行高自动调整，最小高度为100px
    gap: 10px;
    align-items: start;
    align-content: start;

    :deep(.card) {
      cursor: pointer;
      width: 100%;
      font-size: 14px;
      margin: 0;

      .card-item {
        margin: 10px;
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: left;
        align-items: center;

        .elImage {
          width: 50px;
          height: 50px;
          margin-left: 5px
        }
      }

      .el-card__body {
        padding: 0;
      }
    }

    .contents {
      width: 80%;
      margin-left: 10px;
    }

    .name, .description {
      margin: 8px 0;
      padding-right: 34px;
    }

    .description {
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
    }

    .name {
      font-weight: bold;
    }
  }


  .pagination {

  }
}

@media (max-width: 600px) {
  .appBody {
    width: 100%;
    margin: 0;
    padding: 10px 0;
    height: calc(100% - 100px);

    .appList {
      gap: 10px;
      padding: 0;
    }
  }
}
</style>
