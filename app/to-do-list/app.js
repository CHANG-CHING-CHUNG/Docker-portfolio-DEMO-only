/* eslint-disable no-param-reassign */
/* eslint-disable no-alert */
/* eslint-disable array-callback-return */
/* eslint-disable consistent-return */
/* eslint-disable no-restricted-globals */

document.addEventListener('DOMContentLoaded', () => {
  const inputBar = document.getElementById('input-bar');
  const addBtn = document.getElementById('add');
  const search = document.getElementById('search');
  const displaySection = document.querySelector('.lists-display');
  const clearAll = document.getElementById('clear-all');
  
  function addTaskToLists(task) {
    const listDiv = document.createElement('div');
    listDiv.classList.add('list');
    
    if ($(".all-btn").hasClass("current")) {
      listDiv.classList.add('all');
    }

    const taskDiv = document.createElement('div');
    taskDiv.classList.add('full-width');
    
    const checkBox = document.createElement('input');
    checkBox.classList.add('check');
    checkBox.type = 'checkbox';
    const taskText = document.createElement('div');
    taskText.classList.add('list-text');
    taskText.innerText = task;
    
    const iconContainer = document.createElement('div');
    
    const editIcon = document.createElement('i');
    editIcon.classList = 'fas fa-edit edit-item';
    const deleteIcon = document.createElement('i');
    deleteIcon.classList = 'fas fa-trash-alt 2x delete-item';
    
    taskDiv.appendChild(checkBox);
    taskDiv.appendChild(taskText);
    listDiv.appendChild(taskDiv);
    iconContainer.appendChild(editIcon);
    iconContainer.appendChild(deleteIcon);
    listDiv.appendChild(iconContainer);
    displaySection.appendChild(listDiv);
  }

  function deleteTask(e) {
    if (e.target.classList.contains('delete-item')) {
      if (confirm('確定要刪除嗎?')) {
        const list = e.target.parentElement.parentElement;
        list.remove();
        const listText = e.target.parentElement.parentElement.firstElementChild.lastElementChild;
        removeTaskFromLocalStorage(listText);
      }
    }
  }
  
  function clearAllTasks() {
    const lists = Array.from(document.getElementsByClassName('list'));
    const tasks = [];
    localStorage.setItem('tasks', JSON.stringify(tasks));
    lists.forEach((list) => {
      list.remove();
    });
  }

  function searchTask() {
    const searchItem = inputBar.value.toLowerCase();
    const lists = Array.from(document.getElementsByClassName('list-text'));
    lists.forEach((list) => {
      const listTxt = list.textContent;
      if (listTxt.toLowerCase().indexOf(searchItem) !== -1) {
        $(list).parent().parent().addClass("all");
      } else {
        $(list).parent().parent().addClass('hidden');
      }
    });
  }

  function editTask(e) {
    if (e.target.classList.contains('edit-item')) {
      // eslint-disable-next-line prefer-const
      e.target.classList.remove('edit-item');
      e.target.classList.add('editing');
      const text = e.target.parentElement.previousElementSibling.lastElementChild.textContent;
      const parent = e.target.parentElement.previousElementSibling;
      cancelCheckState(parent.firstElementChild);
      const child = e.target.parentElement.previousElementSibling.lastElementChild;
      child.remove();
      const newChild = document.createElement('input');
      newChild.classList.add('list-text');
      newChild.type = 'text';
      newChild.value = text;
      parent.appendChild(newChild);
    } else if (e.target.classList.contains('editing')) {
      const editIcons = Array.from(document.getElementsByClassName('fa-edit'));
      let editingTextIndex;
      editIcons.forEach((icon, idx) => {
        if (icon.classList.contains('editing')) {
          editingTextIndex = idx;
        }
      });
      const newText = e.target.parentElement.previousElementSibling.lastElementChild.value;
      const parent = e.target.parentElement.previousElementSibling;

      const child = e.target.parentElement.previousElementSibling.lastElementChild;
      child.remove();
      const newChild = document.createElement('div');
      newChild.classList.add('list-text');
      newChild.textContent = newText;
      parent.appendChild(newChild);
      const tasks = getTasksFromLocalStorage();
      tasks[editingTextIndex].title = newText;
      localStorage.setItem('tasks', JSON.stringify(tasks));
      e.target.classList.remove('editing');
      e.target.classList.add('edit-item');
    }
  }

  function cancelCheckState(checkBox) {
    if (checkBox.classList.contains('check')) {
      checkBox.checked = false;
      checkBox.nextElementSibling.classList.toggle('strikethrough');
    }
  }

  function getTasksFromLocalStorage() {
    let tasks;
    if (localStorage.getItem('tasks') === null) {
      tasks = [];
    } else {
      tasks = JSON.parse(localStorage.getItem('tasks'));
    }
    return tasks;
  }

  function storeTaskInLocalStorage(task, completed = false) {
    const tasks = getTasksFromLocalStorage();
    const taskObj = {
      title: task,
      completed: completed
    }
    tasks.push(taskObj);
    localStorage.setItem('tasks', JSON.stringify(tasks));
  }
  
  function removeTaskFromLocalStorage(taskItem) {
    let tasks;
    if (localStorage.getItem('tasks') === null) {
      tasks = [];
    } else {
      tasks = JSON.parse(localStorage.getItem('tasks'));
    }

    tasks.every((task, index) => {
      if (taskItem.textContent === task.title) {
        tasks.splice(index, 1);
        return 0;
      }
    });

    localStorage.setItem('tasks', JSON.stringify(tasks));
  }

  function displayTasks() {
    const tasks = getTasksFromLocalStorage();
    tasks.forEach((task) => {
      addTaskToLists(task.title);
    });
  }
  displayTasks();

  function getListsFromDatabase(listId) {
    $.ajax({
      type: 'GET',
      url: `get_lists.php?id=${listId}`,
      success: function(data) {
        data = JSON.parse(data);
        data.data = JSON.parse(data.data);
        data.data.map(list=> {
          return list.completed = JSON.parse(list.completed);
        })
        storeToLocal(data)
      }
    })
  }

  function storeToLocal(data) {
    clearAllTasks();
    data.data.forEach((list,i) => {
      storeTaskInLocalStorage(list.title, list.completed);
    })
    displayTasks();
    showAllLists();
  }

  function updateStorageLists() {
    const tasks = getTasksFromLocalStorage();
    const currentLists = getAllLists();
    currentLists.each((i,list)=> {
       if ($(list).hasClass("completed")) {
          tasks[i].completed = true;
       } else {
        tasks[i].completed = false;
       }
    })
    localStorage.setItem('tasks', JSON.stringify(tasks));
  }

  
  addBtn.addEventListener('click', () => {
    const task = inputBar.value;
    if (!task) {
      return
    }
    addTaskToLists(task);
    storeTaskInLocalStorage(task);
  });
  
  search.addEventListener('click', () => {
    searchTask();
  });
  
  clearAll.addEventListener('click', () => {
    clearAllTasks();
  });
  
  displaySection.addEventListener('click', (e) => {
    if (e.target.classList.contains('delete-item')) {
      if (e.target.previousElementSibling.classList.contains('editing')) {
        alert('請編輯完再刪除!');
      } else {
        deleteTask(e);
      }
    }
  });
  
  
  function triggerAllBtn() {
    $(".current").removeClass("current");
    const allBtn = $(".all-btn");
    allBtn.addClass("current");
  }
  function triggerActiveBtn() {
    $(".current").removeClass("current");
    const allBtn = $(".active-btn");
    allBtn.addClass("current");
  }
  function triggerCompletedBtn() {
    $(".current").removeClass("current");
    const allBtn = $(".completed-btn");
    allBtn.addClass("current");
  }

  function clearClasses() {
    $(".all").removeClass("all");
    $(".active").removeClass("active");
    $(".completed").removeClass("completed");
    $(".hidden").removeClass("hidden");
    
  }

  function initAllBtn() {
    triggerAllBtn();
    clearClasses();
    showAllLists();
  }
  initAllBtn()

  $(".all-btn").on("click",() => {
    triggerAllBtn();
    clearClasses();
    showAllLists();
  })
  $(".active-btn").on("click",() => {
    triggerActiveBtn();
    clearClasses()
    showActiveLists();
  })
  $(".completed-btn").on("click",() => {
    triggerCompletedBtn();
    clearClasses();
    showCompletedLists();
  })
  
 

  function getAllLists() {
    const lists = $(".list");
    return lists;
  }

  function showActiveLists() {
    const tasks = getTasksFromLocalStorage();
    const lists = getAllLists();
    tasks.forEach((task,i)=> {
      if (task.completed) {
        $(lists[i]).addClass("completed");
        $(lists[i]).addClass("hidden");
        $(lists[i]).find(".list-text").addClass("strikethrough");
        $(lists[i]).find(".check").prop("checked", true);
      } else {
        $(lists[i]).addClass("active");
      }
    })
  }
  function showCompletedLists() {
    const tasks = getTasksFromLocalStorage();
    const lists = getAllLists();
    tasks.forEach((task,i)=> {
      if (task.completed) {
        $(lists[i]).addClass("completed");
        $(lists[i]).find(".list-text").addClass("strikethrough");
        $(lists[i]).find(".check").prop("checked", true);
      } else {
        $(lists[i]).addClass("hidden");
      }
    })
  }

  function showAllLists() {
    const tasks = getTasksFromLocalStorage();
    const lists = getAllLists();
    lists.each((i,list)=> {
      $(list).addClass("all");
    })
    tasks.forEach((task,i)=> {
      if (task.completed) {
        $(lists[i]).addClass("completed");
        $(lists[i]).find(".list-text").addClass("strikethrough");
        $(lists[i]).find(".check").prop("checked", true);
      }
    })
  }
  
 

  const saveBtn = $(".save-btn");
  saveBtn.on("click", () => {
    sendListsToDatabase()
  })

  function updateUrlWithParam(id) {
    const currentUrl = "http://www.mentor4th-john.tw/to-do-list/index.html";
    // const currentUrl = "http://mentor-program.co/mtr04group2/John/week12/hw2/index.html";
    const url = new URL(currentUrl);
    url.searchParams.set("id",id);
    const newURL = url.href;
    history.pushState(null, document.title, newURL);
  }

  function sendListsToDatabase() {
    const tasks = getTasksFromLocalStorage();

    $.post("save_lists.php", {
      data:tasks
    }).done((data) => {
      updateUrlWithParam(data);
      getListsFromDatabase(data);
    })
  }

  function getListsByQueryStr() {
    if (!checkQueryString()) {
      return
    }
    loadListsByQueryID();
  }

  function checkQueryString() {
    let queryStr = $(location).attr('search').match(/^\?id\=\d+/);
    if (!queryStr) {
      return false
    }
    return true;
  }

  
  function getIDfromQuery() {
    const id = $(location).attr('search').match(/^\?id\=\d+/)[0].match(/\d+/)[0];
    return id;
  }

  function loadListsByQueryID() {
    const id = getIDfromQuery();
    getListsFromDatabase(id);
  }
  
  getListsByQueryStr()
  displaySection.addEventListener('click', (e) => {
    if (e.target.classList.contains('check')) {
      e.target.nextElementSibling.classList.toggle('strikethrough');
      $(e.target.parentElement.parentElement).toggleClass("completed");
      updateStorageLists();
    }
  });


  displaySection.addEventListener('click', (e) => {
    editTask(e);
  });
});
