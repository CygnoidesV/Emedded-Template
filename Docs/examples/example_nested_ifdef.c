
uint16_t key_press_cnt = 0;
#define USE_KEY 1
#define DEBOUNCING 1
#define DEBOUCING_PRESS_CNT 1000
#define USE_INTERRUPT 1

while (1)
{
#if USE_INTERRUPT == 0
#if USE_KEY
    uint8_t key;
#if DEBOUNCING
    key_press_cnt = 0;
    while(HAL_GPIO_ReadPin(KEY_GPIO_Port,KEY_Pin) == 0)
    {
        key_press_cnt++;
    }
    key = key_press_cnt < DEBOUCING_PRESS_CNT;
#else
    key = HAL_GPIO_ReadPin(KEY_GPIO_Port,KEY_Pin);
#endif
    if(key == 0)
    {
        state = ~state & 0x1;
    }
#else
    state = ~state & 0x1;
    HAL_Delay(100);
#endif
#endif	
    HAL_GPIO_WritePin(LED1_GPIO_Port,LED1_Pin,state);
    HAL_Delay(1);
}