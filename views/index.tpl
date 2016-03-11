% include('header.tpl')
<div class="container">
    % if defined('error'):
        <div class="alert alert-danger" role="alert">
            {{error}}
        </div>
    % end
</div>
% include('footer.tpl')

