# PR 2841 的输入材料（合成）

base SHA：a100；head SHA：b200。提案升级共享库 packages/search-client 中 query-core 2.8.4 → 3.0.1，同时锁文件解析使 query-native 1.9.0 → 2.1.0。业务代码只改了 package.json 和 lockfile。apps/catalog 和 apps/search-api 都消费 search-client；catalog 使用分页游标，search-api 只使用首屏结果。

基线：最后一次 a100 的完整 CI 为绿色，运行 Node 18.20，使用安装缓存。共享库自有单测使用 query-core mock；catalog 集成测试连接本地模拟服务，不访问生产。

## 组织缓存发行说明

query-core 3.0.1：
- Node engine >=20。
- Client.search(query, options) 返回 SearchPage 对象，旧版返回数组。SearchPage.items 为结果数组，nextCursor 为 string|null。
- 搜索重试默认启用；调用端 retry:false 可关闭。旧版默认不重试。
- 分页游标格式更换，服务端 query-server >=5.2 才理解新游标；无游标的首屏请求保持兼容。

query-native 2.1.0：
- optional dependency；导出向量加速功能，无该包时 query-core 可使用纯 JS 路径。
- 提供 Node 20/22 的预构建二进制。是否需要编译取决于平台与下载结果。

组织本地模拟服务当前 query-server 5.1。生产服务由另一个团队维护，版本未知，当前无生产读取权限。

## 代码节选

packages/search-client/index.ts：
```ts
export async function find(query: string, cursor?: string) {
  const result = await client.search(query, { cursor });
  return result.map(row => ({ id: row.id, title: row.title }));
}
```

apps/catalog 的调用路径将上次获得的 cursor 传回 find。此节选没有展示 cursor 在共享库外如何保存或返回；read_change 可以读取完整文件。当前 mock 返回数组。
