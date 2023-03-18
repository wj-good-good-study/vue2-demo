<!--  -->
<template>
    <div class="searchNav">
        <div class="search_left">
            {{search.leftText}}
            <i :class="search.leftIcon"></i>
        </div>
        <div class="search_input">
            <div class="search_icon">
                <i :class="search.searchIcon" id="searchIcon"></i>
            </div>
            <input type="text" :placeholder="search.placeholder">
        </div>
        <div class="search_right">
            <i :class="search.peopleIcon" style="font-size: 25px;"></i>
        </div>
    </div>
</template>

<script>
    export default {
        props: ["search"]
    }
</script>

<style>
    .searchNav {
        position: fixed;
        top: 0;
        display: flex;
        width: 100%;
        height: 40px;
        background-color: white;
        justify-content: space-around;
        align-items: center;
        padding: 3px;
        z-index: 1000;
    }

    .searchNav input {
        width: 100%;
        height: 25px;
        text-indent: 40px;
        border: none;
        background-color: #f4f4f4;
    }

    .search_input{
        width: 250px;
        border-radius: 20px;
        height: 26px;
        display: inline-flex;
        background-color: #f4f4f4;
        overflow: hidden;
    }

    .search_input input{
        width: 85%;
        margin-left: 10px;
        margin-top: 3px;
        height: 20px;
        text-indent: 0;
        font-size: 12px;
        background-color: #f4f4f4;
    }

    .search_icon{
        margin-left: 10px;
        width: auto;
        height: 20px;
        padding-top: 3px;
    }

    #searchIcon {
        font-size: 13px;
    }
</style>