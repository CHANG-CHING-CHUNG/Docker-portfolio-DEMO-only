/* eslint-disable no-param-reassign */
/* eslint-disable quote-props */

document.addEventListener("DOMContentLoaded", () => {
  const navbar = document.querySelector(".main--navbar");
  const navbtns = document.querySelectorAll(".main--navlink");
  const streamsBox = document.querySelector("#live-streams-box");
  const loadMore = document.querySelector("#load-more-btn");
  const gameTitle = document.querySelector(".title");
  const streamDesBox = document.querySelector(".stream-des-box");
  let isLoading = false;

  function getTopGames() {
    const options = {
      headers: {
        "Client-ID": "",
        Accept: "application/vnd.twitchtv.v5+json",
      },
    };
    return fetch("https://api.twitch.tv/kraken/games/top", options)
      .then((data) => data.json())
      .then((data) => data.top);
  }

  function getTotalStreams(game = "Just Chatting", total = 20) {
    let totalLimit = total;
    if (totalLimit > 100) {
      totalLimit = 100;
    }
    const offset = 0;
    const options = {
      headers: {
        "Client-ID": "",
        Accept: "application/vnd.twitchtv.v5+json",
      },
    };

    if (isLoading === false) {
      isLoading = true;
      fetch(
        `https://api.twitch.tv/kraken/streams/?game=${game}&limit=${totalLimit}&offset=${offset}`,
        options
      )
        .then((data) => data.json())
        .then((data) => {
          data.streams.forEach((stream) => {
            const div = document.createElement("div");
            div.className = "stream";
            const streamContent = `
              <a target="_blank" href="${stream.channel.url}">
                <img src="${stream.preview.medium}">
                <div class="logo-box">
                  <img class="logo" src="${stream.channel.logo}">
                  <div class="status-box">
                    <div class="status">
                    ${stream.channel.status}
                    </div>
                    <div class="name">
                    ${stream.channel.name}
                    </div>
                  </div>
                </div>
              </a>
            `;
            div.innerHTML = streamContent;
            streamsBox.appendChild(div);
          });
          loadMore.className = "display";
          isLoading = false;
        });
    }
  }

  function loadMoreStreams(
    game = "Just Chatting",
    total = 20,
    startOffset = 20
  ) {
    let totalLimit = total;
    if (totalLimit > 100) {
      totalLimit = 100;
    }
    const offset = startOffset;
    const options = {
      headers: {
        "Client-ID": "",
        Accept: "application/vnd.twitchtv.v5+json",
      },
    };

    fetch(
      `https://api.twitch.tv/kraken/streams/?game=${game}&limit=${totalLimit}&offset=${offset}`,
      options
    )
      .then((data) => data.json())
      .then((data) => {
        console.log(data.streams);
        if (data.streams.length === 0) {
          loadMore.className = "";
        }
        data.streams.forEach((stream) => {
          const div = document.createElement("div");
          div.className = "stream";
          const streamContent = `
          <a target="_blank" href="${stream.channel.url}">
            <img src="${stream.preview.medium}">
            <div class="logo-box">
              <img class="logo" src="${stream.channel.logo}">
              <div class="status-box">
                <div class="status">
                ${stream.channel.status}
                </div>
                <div class="name">
                ${stream.channel.name}
                </div>
              </div>
            </div>
          </a>
        `;
          div.innerHTML = streamContent;
          streamsBox.appendChild(div);
        });
      });
  }

  function addEventListenerToNavbar() {
    let startOffset = 20;
    let currentPage;

    navbar.addEventListener("click", (e) => {
      if (isLoading === false) {
        if (e.target.classList.contains("main--navlink")) {
          const name = e.target.textContent;
          if (currentPage !== name || currentPage === undefined) {
            streamsBox.innerHTML = "";
            gameTitle.textContent = name;
            streamDesBox.classList.add("display");
            loadMore.className = "";
            getTotalStreams(name);
            currentPage = name;
          }
        }
      }
    });

    loadMore.addEventListener("click", () => {
      if (currentPage !== undefined) {
        loadMoreStreams(currentPage, 20, startOffset);
        startOffset += 20;
      }
    });
  }

  const names = getTopGames();

  names.then((data) => {
    const topFiveGames = [];
    for (let i = 0; i < 5; i++) {
      topFiveGames.push(data[i].game.name);
    }
    navbtns.forEach((btn, i) => {
      btn.textContent = topFiveGames[i];
    });
    addEventListenerToNavbar();
  });
});
