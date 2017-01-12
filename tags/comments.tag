<comment-box>
    <h1>{ opts.title }</h1>

    <comment-list url={ opts.url } comments={ comments }/>
    <comment-form/>

    <script>
        this.comments = [];

        this.add = function(comment) {
            this.comments.push(comment);
            this.update();
        }

        this.load = function() {
            var self = this;
            $.ajax({
                url: 'https://jsonplaceholder.typicode.com/posts'
            }).then(function(response) {
                self.comments = response;
                self.update();
            });
        }

        this.load();
    </script>
</comment-box>

<comment-list>
    <comment each={ opts.comments } name={ this.title } message={ this.body }/>
</comment-list>

<comment-form>
    <form onsubmit={ add }>
        <input type="text" placeholder="Your name" name="name">
        <textarea cols="40" rows="40" placeholder="Say something..." name="message"></textarea>
        <input type="submit" value="Post">
    </form>

    <script>
        this.add = function(e) {
            var comment = {
                name: this.name.value,
                message: this.message.value
            }

            this.parent.add(comment);
            this.post(comment, e.target);
        }

        this.post = function(comment, form) {
            var self = this;
            $.ajax({
                url: 'https://jsonplaceholder.typicode.com/posts',
                type: 'POST'
            }).then(function(response, textStatus, xhr) {
                if (xhr.status >= 200 && xhr.status < 400) {
                    form.reset();
                    // You might want to flash a message now
                }
            });
        }
    </script>
</comment-form>

<comment>
    <div>
        <h2>{ opts.name }</h2>
        <p>{ opts.message }</p>
    </div>
</comment>