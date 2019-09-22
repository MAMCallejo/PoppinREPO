#ifndef __Lab14__SharedQueue__
#define __Lab14__SharedQueue__

#include <mutex>

template <typename T>
class SharedQueue {
public:
  SharedQueue();
  ~SharedQueue();
  
    /*
     These declarations mean that we do NOT get the automatically
     defined copy/copy-assign functions.  If you try to call one
     by copying the queue, you'll get a compiler error.
     
     This is a common technique for things that are uncopyable (like std::thread and std::mutex, for example).
     
     We really DO want a destructor, so cheating at the
     rule of 3 here makes sense here.
     */
    SharedQueue(const SharedQueue<T>&) = delete;
    SharedQueue<T>& operator=(const SharedQueue<T>&) = delete;

    
  //Return true if the queue is empty
  bool IsEmpty() const;
  
  //Enqueue the next item at the tail of the queue.
  void Add(T value);
  
  //Dequeue the next queue element and store it in "item" variable.  The function returns false if the queue is empty and no item can be retrieved.
  bool Remove(T &item);
  void Print();
private:
  struct QueueItem {
    T item;
    QueueItem *next;
  };
  
  //Fill in the The private data members.
    std::mutex lock;
    QueueItem *head;
    QueueItem *tail;
};

template<typename T>
SharedQueue<T>::SharedQueue(){
    head = new QueueItem;
    tail = new QueueItem;
    head = nullptr;
    tail = nullptr;
}

template<typename T>
SharedQueue<T>::~SharedQueue(){
    QueueItem *temp = head;
    while(temp != nullptr){
        temp = temp->next;
        delete head;
        head = temp;
    }
    head = nullptr;
    tail = nullptr;
}

template<typename T>
bool SharedQueue<T>::IsEmpty() const{
    if(head == nullptr){
        return true;
    }
    
    return false;
}

template<typename T>
void SharedQueue<T>::Add(T value){
    if(head == nullptr){
        QueueItem *temp = new QueueItem;
        temp->item = value;
        temp->next = nullptr;
        head = temp;
        tail = temp;
    }else{
        QueueItem *temp = new QueueItem;
        temp->item = value;
        temp->next = nullptr;
        tail->next = temp;
        tail = temp;
    }
    
    
}

template<typename T>
bool SharedQueue<T>::Remove(T &item){
    if(head == nullptr){
        return false;
    }
    else{
        lock.lock();
        item = head->item;
        QueueItem *temp = new QueueItem;
        temp = head;
        
        head = head->next;
        delete temp;
        lock.unlock();
        return true;
        
    }
}

template<typename T>
void SharedQueue<T>::Print(){
    if(head == nullptr){
        std::cout << "Queue is empty" << "\n";
    }
    QueueItem *temp = head;
    while(temp != nullptr){
        std::cout << temp->item << " ";
        temp = temp->next;
    }
    std::cout << "\n";
}


//Fill in the function definitions

#endif
