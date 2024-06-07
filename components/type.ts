interface App {
  icon: string;
  name: string;
  description: string;
  url: string;
}

export interface AppConfig {
  data: string;
  type: string;
  appList: App[];
}
