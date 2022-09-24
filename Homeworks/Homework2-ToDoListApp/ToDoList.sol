// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Todos {
    //yapimiz iki adet bilgi icerir
    //yapilacak olan plan
    //yapilip yapilmadigina dair bool deger tutan completed
    struct Todo {
        string text;
        bool completed;
    }

    // Todo yapisinda yapilacaklar listesi
    Todo[] public todos;
    
    // olusturmak icin iki bilgi, gorev ve tamamlanma bilgisi
    // olusturma asamasinda tamamlanma bilgisi false olarak ayarlandi
    function create(string calldata _text) public {

        todos.push(Todo(_text, false));

        // key value mapping
        todos.push(Todo({text: _text, completed: false}));

        // bos bir struct baslatiyoruz ve onu girilen parametreye guncelliyoruz
        Todo memory todo;
        todo.text = _text;

        todos.push(todo);
    }

    // Solidity todos'da zaten yapilacaklari getiriyo fakat alistirma olmasi icin
    // get fonksiyonunu yaziyoruz
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // yapilacaklari guncellemek icin
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // Tamamlanma durumunu guncelliyoruz
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
