void some_function_not_main_up_top() {
    
}

void main() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}