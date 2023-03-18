<!-- 儿子 -->
<template>
    <div>
        <input type="text" v-model="text">
        <button @click="add">提交</button>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                textList: this.List,
                text: '',
            }
        },
        methods: {
            add() {
                if (this.text !== '') {
                    this.textList.push({ text: this.text });
                    localStorage.setItem('text', JSON.stringify(this.textList));
                    this.text = '';
                    this.$emit('fun');
                }

            }
        },
        props: ['List']
    }
</script>

<style>

</style>